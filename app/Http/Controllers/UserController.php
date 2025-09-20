<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Auth;


class UserController extends Controller
{
    use AuthorizesRequests;

    /**
     * Get all users (admin only)
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function index()
    {
        try {
            $this->authorize('viewAny', User::class);

            $users = User::withCount(['posts', 'comments'])
                ->orderBy('name')
                ->paginate(10);

            return response()->json([
                'message' => 'Users retrieved successfully',
                'users' => $users
            ]);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to view users'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve users',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function show($id)
    {
        try {
            $user = User::with(['posts' => function ($query) {
                $query->published()
                    ->with(['tags', 'comments' => function ($q) {
                        $q->with('user')->limit(5);
                    }])
                    ->latest();
            }])
                ->withCount(['posts', 'comments'])
                ->findOrFail($id);

            return response()->json([
                'message' => 'User retrieved successfully',
                'user' => $user
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'User not found'
            ], 404);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve user',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function update(Request $request, $id)
    {
        try {
            $user = User::findOrFail($id);

            $this->authorize('update', $user);

            $validator = Validator::make($request->all(), [
                'name' => ['sometimes', 'string', 'max:255'],
                'email' => [
                    'sometimes',
                    'string',
                    'email',
                    'max:255',
                    Rule::unique('users')->ignore($user->id)
                ],
                'password' => ['sometimes', 'string', 'min:8', 'confirmed'],
                'bio' => ['sometimes', 'string', 'max:500', 'nullable'],
                'avatar' => ['sometimes', 'string', 'max:255', 'nullable'],
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            $updateData = $request->only(['name', 'email', 'bio', 'avatar']);

            // Handle password update
            if ($request->has('password')) {
                $updateData['password'] = Hash::make($request->password);
            }

            $user->update($updateData);

            return response()->json([
                'message' => 'User updated successfully',
                'user' => $user->fresh() // Get fresh instance from database
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'User not found'
            ], 404);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to update this user'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update user',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function destroy($id)
    {
        try {
            $user = User::findOrFail($id);

            $this->authorize('delete', $user);

            // Prevent users from deleting themselves
            // if (auth()->id() === $user->id) {
            //     return response()->json([
            //         'message' => 'You cannot delete your own account'
            //     ], 422);
            // }

            if (Auth::id() === $user->id) {
                return response()->json([
                    'message' => 'You cannot delete your own account'
                ], 422);
            }

            $user->delete();

            return response()->json([
                'message' => 'User deleted successfully'
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'User not found'
            ], 404);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to delete users'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to delete user',
                'error' => $e->getMessage()
            ], 500);
        }
    }



    public function profile(Request $request)
    {
        try {
            $user = $request->user()->loadCount(['posts', 'comments']);

            return response()->json([
                'message' => 'Profile retrieved successfully',
                'user' => $user
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to retrieve profile',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function updateRole(Request $request, $id)
    {
        try {
            $user = User::findOrFail($id);

            $this->authorize('updateRole', $user); // You'll need to add this method to UserPolicy

            $validator = Validator::make($request->all(), [
                'role' => ['required', 'string', 'in:user,admin,moderator']
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            $user->update([
                'role' => $request->role
            ]);

            return response()->json([
                'message' => 'User role updated successfully',
                'user' => $user
            ]);
        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'message' => 'User not found'
            ], 404);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to update user roles'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to update user role',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function search(Request $request)
    {
        try {
            $this->authorize('viewAny', User::class);

            $validator = Validator::make($request->all(), [
                'query' => ['required', 'string', 'min:2', 'max:255']
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            $users = User::where('name', 'like', '%' . $request->query . '%')
                ->orWhere('email', 'like', '%' . $request->query . '%')
                ->withCount(['posts', 'comments'])
                ->paginate(10);

            return response()->json([
                'message' => 'Users found successfully',
                'users' => $users
            ]);
        } catch (\Illuminate\Auth\Access\AuthorizationException $e) {
            return response()->json([
                'message' => 'You are not authorized to search users'
            ], 403);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to search users',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
