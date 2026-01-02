<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;
use App\Notifications\ResetPasswordApi;


class AuthController extends Controller
{
    // User Registration
    public function register(Request $request){
        $request->validate([
            'name'=>'required',
            'username'=>'required|unique:users',
            'email'=>'required|email|unique:users',
            'password'=>'required|min:6|confirmed'
        ]);

        if($request->hasFile('image')){
            $image = $request->file('image');
            $imageName = time().'_'.$image->getClientOriginalName();
            $image->move(public_path('uploads/profile'), $imageName);
        }else{
            $imageName = 'default.png';
        }

        $user = User::create([
            'name'=>$request->name,
            'username'=>$request->username,
            'email'=>$request->email,
            'password'=>bcrypt($request->password),
            'image'=>$imageName
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'user'=>$user,
            'token'=>$token
        ],201);
    }

    // User Login
    public function login(Request $request){
        if(!Auth::attempt($request->only('email','password'))){
            return response()->json(['message'=>'Invalid credentials'],401);
        }

        $user = Auth::user();
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'user'=>$user,
            'token'=>$token
        ]);
    }

    // User Logout
    public function logout(Request $request){
        $request->user()->tokens()->delete();
        return response()->json(['message'=>'Logged out successfully']);
    }

    // Profile Upload
    public function uploadProfile(Request $request){
        $request->validate([
            'image'=>'required|image|mimes:jpeg,png,jpg,gif|max:2048'
        ]);

        $user = $request->user();
        $image = $request->file('image');
        $imageName = time().'_'.$image->getClientOriginalName();
        $image->move(public_path('uploads/profile'), $imageName);

        if($user->image !== 'default.png' && file_exists(public_path('uploads/profile/'.$user->image))){
            unlink(public_path('uploads/profile/'.$user->image));
        }

        $user->image = $imageName;
        $user->save();

        return response()->json(['message'=>'Profile updated','user'=>$user]);
    }

    // Forgot Password
    public function forgotPassword(Request $request){
    $request->validate(['email'=>'required|email']);

    $user = User::where('email', $request->email)->first();
    if (!$user) {
        return response()->json(['message'=>'Email not found'], 404);
    }

    $token = app('auth.password.broker')->createToken($user);
    $user->notify(new ResetPasswordApi($token));

    return response()->json(['message'=>'Reset link sent to your email']);
}

    // Reset Password
    public function resetPassword(Request $request){
        $request->validate([
            'token'=>'required',
            'email'=>'required|email',
            'password'=>'required|min:6|confirmed'
        ]);

        $status = Password::reset(
            $request->only('email','password','password_confirmation','token'),
            function($user,$password){
                $user->password = bcrypt($password);
                $user->save();
            }
        );

        return $status === Password::PASSWORD_RESET
            ? response()->json(['message'=>'Password reset successfully'])
            : response()->json(['message'=>'Failed to reset password'], 500);
    }
}
