<?php

namespace App\Http\Controllers;

use App\Models\Penayangan;
use Illuminate\Http\Request;

class PenayanganController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $penayangans = Penayangan::with(['film', 'studio', 'sesi'])->get(); // Include relationships
        return response()->json($penayangans);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'id_film' => 'required|exists:films,id',
            'id_sesi' => 'required|exists:sesis,id',
            'id_studio' => 'required|exists:studios,id',
            'nomor_kursi_tersedia' => 'required|integer|min:0',
            'nomor_kursi_terpakai' => 'required|integer|min:0',
            'harga_tiket' => 'required|numeric|min:0',
            'status' => 'required|string',
            'tanggal_tayang' => 'required|date',
        ]);

        $penayangan = Penayangan::create($request->all());
        return response()->json($penayangan);
    }

    /**
     * Display the specified resource.
     */
    public function show(Penayangan $penayangan)
    {
        return response()->json($penayangan->load(['film', 'studio', 'sesi'])); // Include relationships
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Penayangan $penayangan)
    {
        $request->validate([
            'id_film' => 'required|exists:films,id',
            'id_sesi' => 'required|exists:sesis,id',
            'id_studio' => 'required|exists:studios,id',
            'nomor_kursi_tersedia' => 'required|integer|min:0',
            'nomor_kursi_terpakai' => 'required|integer|min:0',
            'harga_tiket' => 'required|numeric|min:0',
            'status' => 'required|string',
            'tanggal_tayang' => 'required|date',
        ]);

        $penayangan->update($request->all());
        return response()->json($penayangan);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Penayangan $penayangan)
    {
        $penayangan->delete();
        return response()->json(['message' => 'Penayangan deleted successfully']);
    }
}
