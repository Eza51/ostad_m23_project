<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Api\{
    AuthController,
    PostController,
    CommentController,
    LikeController,
    BookmarkController
};

// Authentication
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);

// Guest → only public posts
Route::get('/posts/public', [PostController::class, 'index']);

// Logged in → all posts (includes private posts of user)
Route::get('/posts', [PostController::class, 'index'])
    ->middleware('auth:sanctum');

Route::get('/comments/{postId}', [CommentController::class, 'index']);

// Authenticated routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::post('/profile/upload', [AuthController::class, 'uploadProfile']);

    Route::post('/posts', [PostController::class, 'store']);
    Route::put('/posts/{id}', [PostController::class, 'update']);
    Route::delete('/posts/{id}', [PostController::class, 'destroy']);

    Route::post('/comments', [CommentController::class, 'store']);
   Route::post('/like/{postId}', [LikeController::class, 'toggle']);

    Route::post('/bookmark/{id}', [BookmarkController::class, 'toggle']);
});


// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');
