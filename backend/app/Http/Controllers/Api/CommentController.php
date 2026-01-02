<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Comment;
use App\Models\Post;
use Illuminate\Support\Facades\Auth;

class CommentController extends Controller
{
    // Add comment or reply
    public function store(Request $request)
    {
        $request->validate([
            'post_id' => 'required|exists:posts,id',
            'comment' => 'required|string',
            'parent_id' => 'nullable|exists:comments,id'
        ]);

        // Optional: check parent comment belongs to same post
        if ($request->parent_id) {
            $parent = Comment::findOrFail($request->parent_id);
            if ($parent->post_id != $request->post_id) {
                return response()->json(['message' => 'Parent comment does not belong to this post'], 400);
            }
        }

        $comment = Comment::create([
            'user_id' => auth()->id(),
            'post_id' => $request->post_id,
            'parent_id' => $request->parent_id,
            'comment' => $request->comment,
        ]);

        return response()->json(['message' => 'Comment added', 'comment' => $comment]);
    }

    // Get all comments for a post (nested)
    public function index($postId)
    {
        $post = Post::findOrFail($postId);

        $comments = Comment::where('post_id', $postId)
            ->whereNull('parent_id') // top-level comments
            ->with(['replies.user', 'user']) // eager load replies & user
            ->get();

        return response()->json($comments);
    }
}
