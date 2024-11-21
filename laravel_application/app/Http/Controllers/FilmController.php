<?php

namespace App\Http\Controllers;

use App\Models\Film;
use Illuminate\Http\Request;

class FilmController extends Controller
{
    // Mendapatkan semua film
    public function index()
    {
        $films = Film::all();
        return response()->json($films, 200);
    }

    // Menyimpan film baru
    public function store(Request $request)
    {
        $film = Film::create($request->all());
        return response()->json($film, 201);
    }

    // Mendapatkan film berdasarkan ID
    public function show($id)
    {
        $film = Film::find($id);
        if (!$film) {
            return response()->json(['message' => 'Film not found'], 404);
        }
        return response()->json($film, 200);
    }

    // Mengupdate film
    public function update(Request $request, $id)
    {
        $film = Film::find($id);
        if (!$film) {
            return response()->json(['message' => 'Film not found'], 404);
        }
        $film->update($request->all());
        return response()->json($film, 200);
    }

    // Menghapus film
    public function destroy($id)
    {
        $film = Film::find($id);
        if (!$film) {
            return response()->json(['message' => 'Film not found'], 404);
        }
        $film->delete();
        return response()->json(['message' => 'Film deleted successfully'], 200);
    }
}
