<?php

namespace App\Http\Controllers;

use App\Models\Studio;
use Illuminate\Http\Request;

class StudioController extends Controller
{
    // Mendapatkan semua studio
    public function index()
    {
        $studios = Studio::all();
        return response()->json($studios, 200);
    }

    // Menyimpan studio baru
    public function store(Request $request)
    {
        $studio = Studio::create($request->all());
        return response()->json($studio, 201);
    }

    // Mendapatkan studio berdasarkan ID
    public function show($id)
    {
        $studio = Studio::find($id);
        if (!$studio) {
            return response()->json(['message' => 'Studio not found'], 404);
        }
        return response()->json($studio, 200);
    }

    // Mengupdate studio
    public function update(Request $request, $id)
    {
        $studio = Studio::find($id);
        if (!$studio) {
            return response()->json(['message' => 'Studio not found'], 404);
        }
        $studio->update($request->all());
        return response()->json($studio, 200);
    }

    // Menghapus studio
    public function destroy($id)
    {
        $studio = Studio::find($id);
        if (!$studio) {
            return response()->json(['message' => 'Studio not found'], 404);
        }
        $studio->delete();
        return response()->json(['message' => 'Studio deleted successfully'], 200);
    }
}
