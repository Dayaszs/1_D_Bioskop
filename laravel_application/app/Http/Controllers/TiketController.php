<?php

namespace App\Http\Controllers;

use App\Models\Tiket;
use Illuminate\Http\Request;

class TiketController extends Controller
{
    // Mendapatkan semua tiket
    public function index()
    {
        $tikets = Tiket::all();
        return response()->json($tikets, 200);
    }

    // Menyimpan tiket baru
    public function store(Request $request)
    {
        $tiket = Tiket::create($request->all());
        return response()->json($tiket, 201);
    }

    // Mendapatkan tiket berdasarkan ID
    public function show($id)
    {
        $tiket = Tiket::find($id);
        if (!$tiket) {
            return response()->json(['message' => 'Tiket not found'], 404);
        }
        return response()->json($tiket, 200);
    }

    // Mengupdate tiket
    public function update(Request $request, $id)
    {
        $tiket = Tiket::find($id);
        if (!$tiket) {
            return response()->json(['message' => 'Tiket not found'], 404);
        }
        $tiket->update($request->all());
        return response()->json($tiket, 200);
    }

    // Menghapus tiket
    public function destroy($id)
    {
        $tiket = Tiket::find($id);
        if (!$tiket) {
            return response()->json(['message' => 'Tiket not found'], 404);
        }
        $tiket->delete();
        return response()->json(['message' => 'Tiket deleted successfully'], 200);
    }
}
