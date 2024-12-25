<!doctype html>

<html
    lang="en"
    class="light-style layout-navbar-fixed layout-menu-fixed layout-compact"
    dir="ltr"
    data-theme="theme-default"
    {{-- don't change it --}}
    data-assets-path="{{ asset('') }}admin/"
    data-template="vertical-menu-template">
<head>
    <meta charset="utf-8"/>
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>

    <title>{{ config('app.name') }}</title>

    <meta name="description" content=""/>

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="{{ asset('admin/img/favicon/favicon.ico') }}"/>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com"/>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
    <link
        href="https://fonts.googleapis.com/css2?family=Public+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&ampdisplay=swap"
        rel="stylesheet"/>

    <!-- Icons -->
    <link rel="stylesheet" href="{{ asset('admin/vendor/fonts/fontawesome.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/fonts/tabler-icons.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/fonts/flag-icons.css') }}"/>

    <!-- Core CSS -->
    <link rel="stylesheet" href="{{ asset('admin/vendor/css/rtl/core.css') }}" class="template-customizer-core-css"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/css/rtl/theme-default.css') }}"
          class="template-customizer-theme-css"/>
    <link rel="stylesheet" href="{{ asset('admin/css/demo.css') }}"/>

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/node-waves/node-waves.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/typeahead-js/typeahead.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/spinkit/spinkit.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/toastr/toastr.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/select2/select2.css') }}"/>
    <link href="https://cdn.datatables.net/v/bs5/dt-2.0.2/datatables.min.css" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/datatables-buttons-bs5/buttons.bootstrap5.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/sweetalert2/sweetalert2.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/bootstrap-select/bootstrap-select.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/select2/select2.css') }}"/>

    <style>
        div.dt-container div.dt-paging > .pagination {
            justify-content: end;
        }

        div.dt-container div.dt-search {
            display: flex;
            flex-direction: column;
            padding: 20px 0;
            border-bottom: 1px solid grey;
        }

        div.dt-container div.dt-search label {
            font-weight: bold !important;
        }

        div.dt-container div.dt-search input {
            max-width: 250px;
            margin: 0;
        }
    </style>
    <!-- Page CSS -->
    @stack('pageCss')

    <!-- Helpers -->
    <script src="{{ asset('admin/vendor/js/helpers.js') }}"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->
    <script src="{{ asset('admin/vendor/js/template-customizer.js') }}"></script>
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="{{ asset('admin/js/config.js') }}"></script>
</head>

<body>
<!-- Layout wrapper -->
<div class="layout-wrapper layout-content-navbar">
    <div class="layout-container">
        <!-- Menu -->
        @include('admin.layouts.partials.sidebar')
        <!-- / Menu -->

        <!-- Layout container -->
        <div class="layout-page">
            <!-- Navbar -->
            @include('admin.layouts.partials.top-nav')
            <!-- / Navbar -->

            <!-- Content wrapper -->
            <div class="content-wrapper">
                <!-- Content -->

                <div class="container-fluid flex-grow-1 container-p-y">
                    @yield('content')
                </div>
                <!-- / Content -->

                <!-- Footer -->
                @include('admin.layouts.partials.footer')
                <!-- / Footer -->

                <div class="content-backdrop fade"></div>
            </div>
            <!-- Content wrapper -->
        </div>
        <!-- / Layout page -->
    </div>

    <!-- Overlay -->
    <div class="layout-overlay layout-menu-toggle"></div>

    <!-- Drag Target Area To SlideIn Menu On Small Screens -->
    <div class="drag-target"></div>

    <!-- Toast Container with Custom z-index -->
    <div id="myToastContainer" class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999;">
    </div>
</div>
<!-- / Layout wrapper -->

<!-- Core JS -->
<!-- build:js admin/vendor/js/core.js -->
<script src="{{ asset('admin/vendor/libs/jquery/jquery.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/popper/popper.js') }}"></script>
<script src="{{ asset('admin/vendor/js/bootstrap.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/node-waves/node-waves.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/perfect-scrollbar/perfect-scrollbar.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/hammer/hammer.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/typeahead-js/typeahead.js') }}"></script>
<script src="{{ asset('admin/vendor/js/menu.js') }}"></script>

<!-- endbuild -->

<!-- Vendors JS -->
<script src="{{ asset('admin/vendor/libs/toastr/toastr.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/select2/select2.js') }}"></script>
<script src="https://cdn.datatables.net/v/bs5/dt-2.0.2/datatables.min.js"></script>
<script src="{{ asset('vendor/datatables/buttons.server-side.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/sweetalert2/sweetalert2.js') }}"></script>

<!-- Main JS -->
<script src="{{ asset('admin/js/main.js') }}"></script>
<script src="{{ asset('admin/js/ajax-request-handler.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/bootstrap-select/bootstrap-select.js') }}"></script>
<!-- Page JS -->
@stack('pageJs')

</body>
</html>