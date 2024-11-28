<?php

namespace App\Http\Controllers;

use App\Models\SesiTayang;
use Illuminate\Http\Request;

class SesiTayangController extends Controller
{
    // Mendapatkan semua sesi
    public function index()
    {
        $sesis = Sesi::all();
        return response()->json($sesis, 200);
    }

    // Menyimpan sesi baru
    public function store(Request $request)
    {
        $sesi = Sesi::create($request->all());
        return response()->json($sesi, 201);
    }

    // Mendapatkan sesi berdasarkan ID
    public function show($id)
    {
        $sesi = Sesi::find($id);
        if (!$sesi) {
            return response()->json(['message' => 'Sesi not found'], 404);
        }
        return response()->json($sesi, 200);
    }

    // Mengupdate sesi
    public function update(Request $request, $id)
    {
        $sesi = Sesi::find($id);
        if (!$sesi) {
            return response()->json(['message' => 'Sesi not found'], 404);
        }
        $sesi->update($request->all());
        return response()->json($sesi, 200);
    }

    // Menghapus sesi
    public function destroy($id)
    {
        $sesi = Sesi::find($id);
        if (!$sesi) {
            return response()->json(['message' => 'Sesi not found'], 404);
        }
        $sesi->delete();
        return response()->json(['message' => 'Sesi deleted successfully'], 200);
    }
}
