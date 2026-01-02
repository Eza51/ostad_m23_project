<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Post;
use Illuminate\Support\Facades\Auth;

class PostController extends Controller
{
  public function index(Request $request)
{
    $userId = $request->user() ? $request->user()->id : null;

    if ($userId) {
        // Logged-in: all posts (including private)
        $posts = Post::with('tags', 'user', 'comments', 'likes', 'bookmarks')->get();
    } else {
        // Guest: only public
        $posts = Post::with('tags', 'user', 'comments', 'likes', 'bookmarks')
                     ->where('visibility', 'public')
                     ->get();
    }

    // Map likes & bookmarks info
    $posts = $posts->map(function($post) use ($userId) {
        // total likes
        $post->likes_count = $post->likes->count();

        // total bookmarks (optional, if needed)
        $post->bookmarks_count = $post->bookmarks->count();

        // check if current user liked it
        $post->is_liked = $userId ? $post->likes->contains('user_id', $userId) : false;

        // check if current user bookmarked it
        $post->is_bookmarked = $userId ? $post->bookmarks->contains('user_id', $userId) : false;

        return $post;
    });

    // Sort latest first
    $posts = $posts->sortByDesc('created_at')->values();

    return response()->json($posts);
}





    // Authenticated: Get all posts of user (optional)
    // public function index()
    // {
    //     return Post::where('user_id', auth()->id())
    //         ->latest()
    //         ->with('tags')
    //         ->get();
    // }

    // Create new post
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
            'visibility' => 'required|in:public,private',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'tags' => 'nullable|array'
        ]);

        $post = Post::create([
            'user_id' => auth()->id(),
            'title' => $request->title,
            'content' => $request->content,
            'visibility' => $request->visibility
        ]);

        // Handle image upload
        if ($request->hasFile('image')) {
            $image = $request->file('image');
            $imageName = time().'_'.$image->getClientOriginalName();
            $image->move(public_path('uploads/posts'), $imageName);
            $post->image = $imageName;
            $post->save();
        }

        // Attach tags
        if ($request->tags) {
            $post->tags()->sync($request->tags);
        }

        return response()->json($post, 201);
    }

    // Update post
    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'sometimes|required|string|max:255',
            'content' => 'sometimes|required|string',
            'visibility' => 'sometimes|required|in:public,private',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            'tags' => 'nullable|array'
        ]);

        $post = Post::where('id', $id)
            ->where('user_id', auth()->id())
            ->firstOrFail();

        $post->update($request->only(['title', 'content', 'visibility']));

        // Handle image upload
        if ($request->hasFile('image')) {
            // Delete old image if exists
            if ($post->image && file_exists(public_path('uploads/posts/'.$post->image))) {
                unlink(public_path('uploads/posts/'.$post->image));
            }

            $image = $request->file('image');
            $imageName = time().'_'.$image->getClientOriginalName();
            $image->move(public_path('uploads/posts'), $imageName);
            $post->image = $imageName;
            $post->save();
        }

        // Update tags
        if ($request->tags) {
            $post->tags()->sync($request->tags);
        }

        return response()->json($post);
    }

    // Delete post
    public function destroy($id)
    {
        $post = Post::where('id', $id)
            ->where('user_id', auth()->id())
            ->firstOrFail();

        // Delete image if exists
        if ($post->image && file_exists(public_path('uploads/posts/'.$post->image))) {
            unlink(public_path('uploads/posts/'.$post->image));
        }

        $post->tags()->detach();
        $post->delete();

        return response()->json(['message' => 'Deleted successfully']);
    }
}
