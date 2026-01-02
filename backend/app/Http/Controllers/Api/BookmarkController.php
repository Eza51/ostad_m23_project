<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Bookmark;
use Illuminate\Support\Facades\Auth;

class BookmarkController extends Controller
{
 public function toggle($postId){
        $bm = Bookmark::where('user_id',auth()->id())
            ->where('post_id',$postId)
            ->first();

        if($bm){
            $bm->delete();
            return response()->json(['message'=>'Removed']);
        }

        Bookmark::create([
            'user_id'=>auth()->id(),
            'post_id'=>$postId
        ]);

        return response()->json(['message'=>'Bookmarked']);
    }
}
