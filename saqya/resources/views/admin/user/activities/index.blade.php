@extends('admin.layouts.app')

@section('content')
    <div class="row">
        <div class="col-xl-12 mb-4 col-lg-12 col-12">
            <div class="card h-100">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0 text-uppercase">
                            Activities
                        </h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card p-3">
        {{ $dataTable->table() }}
    </div>

    <!-- Add New Address Modal -->
    <div class="modal fade" id="modal" tabindex="-1" aria-hidden="true" data-backdrop="static"
         data-keyboard="false">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-simple">
            <div class="modal-content p-3 p-md-5">
                <div class="modal-body">
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    <div id="modalInnerLoader" class="d-flex justify-content-center">
                        <div class="sk-chase sk-primary">
                            <div class="sk-chase-dot"></div>
                            <div class="sk-chase-dot"></div>
                            <div class="sk-chase-dot"></div>
                            <div class="sk-chase-dot"></div>
                            <div class="sk-chase-dot"></div>
                            <div class="sk-chase-dot"></div>
                        </div>
                    </div>
                    <div id="modalInner">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--/ Add New Address Modal -->
@endsection
@push('pageJs')
    {{ $dataTable->scripts() }}
@endpush
