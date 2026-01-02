<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Like;
use Illuminate\Support\Facades\Auth;

class LikeController extends Controller
{
     public function toggle($postId){
        $like = Like::where('user_id',auth()->id())
            ->where('post_id',$postId)
            ->first();

        if($like){
            $like->delete();
            return response()->json(['message'=>'Unliked']);
        }

        Like::create([
            'user_id'=>auth()->id(),
            'post_id'=>$postId
        ]);

        return response()->json(['message'=>'Liked']);
    }
}
