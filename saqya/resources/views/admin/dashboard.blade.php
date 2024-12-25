@extends('admin.layouts.app')

@section('content')
    <div class="row">
        <div class="col-xl-12 mb-4 col-lg-12 col-12">
            <div class="card h-100">
                <div class="card-header">
                    <div class="d-flex justify-content-between mb-3">
                        <h5 class="card-title mb-0 text-uppercase">
                            <span class="text-muted">Hello</span>
                            {{ \Illuminate\Support\Facades\Auth::user()->name }} !
                        </h5>
                        <small class="text-muted">
                            <script>
                                let date = new Date();
                                let options = {weekday: 'long', month: 'short', day: 'numeric', year: 'numeric'};
                                let formattedDate = date.toLocaleDateString('en-US', options);
                                document.write(formattedDate);
                            </script>
                        </small>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row gy-3">
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center">
                                <div class="badge rounded-pill bg-label-primary me-3 p-2">
                                    <i class="ti ti-chart-pie-2 ti-sm"></i>
                                </div>
                                <div class="card-info">
                                    <h5 class="mb-0">{{$total_donation ?? 0}} BD</h5>
                                    <small>Donations</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center">
                                <div class="badge rounded-pill bg-label-info me-3 p-2">
                                    <i class="ti ti-users ti-sm"></i>
                                </div>
                                <div class="card-info">
                                    <h5 class="mb-0">{{$products ?? 0}}</h5>
                                    <small>Products</small>
                                </div>
                            </div>
                        </div>
                       
                        {{-- <div class="col-md-3 col-6">
                            <div class="d-flex align-items-center">
                                <div class="badge rounded-pill bg-label-success me-3 p-2">
                                    <i class="ti ti-currency-dollar ti-sm"></i>
                                </div>
                                <div class="card-info">
                                    <h5 class="mb-0">200 BD</h5>
                                    <small>Commission</small>
                                </div>
                            </div>
                        </div> --}}
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
