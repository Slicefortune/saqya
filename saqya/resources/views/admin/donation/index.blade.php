@extends('admin.layouts.app')

@section('content')
    <div class="row">
        <div class="col-xl-12 mb-4 col-lg-12 col-12">
            <div class="card h-100">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0 text-uppercase">
                            Donation
                        </h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card p-3">
        {{ $dataTable->table() }}
    </div>

@endsection
@push('pageCss')

@endpush
@push('pageJs')
    {{ $dataTable->scripts() }}

@endpush