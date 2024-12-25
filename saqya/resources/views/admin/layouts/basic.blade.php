
<!doctype html>

<html
    lang="en"
    class="light-style layout-wide customizer-hide"
    dir="ltr"
    data-theme="theme-default"
    data-assets-path="{{ asset('') }}admin/"
    data-template="vertical-menu-template">
<head>
    <meta charset="utf-8"/>
    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"/>

    <title>Login Basic - {{ config('app.name') }}</title>

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
    <!-- Vendor -->
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/@form-validation/form-validation.css') }}"/>

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="{{ asset('admin/vendor/css/pages/page-auth.css') }}"/>

    <!-- Helpers -->
    <script src="{{ asset('admin/vendor/js/helpers.js') }}"></script>
    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Template customizer: To hide customizer set displayCustomizer value false in config.js.  -->
    <script src="{{ asset('admin/vendor/js/template-customizer.js') }}"></script>
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="{{ asset('admin/js/config.js') }}"></script>
</head>

<body>
<!-- Content -->
@yield('content')
<!-- / Content -->

<!-- Core JS -->
<!-- build:js assets/vendor/js/core.js -->

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
<script src="{{ asset('admin/vendor/libs/@form-validation/popular.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/@form-validation/bootstrap5.js') }}"></script>
<script src="{{ asset('admin/vendor/libs/@form-validation/auto-focus.js') }}"></script>

<!-- Main JS -->
<script src="{{ asset('admin/js/main.js') }}"></script>

<!-- Page JS -->
<script src="{{ asset('admin/js/pages-auth.js') }}"></script>
</body>
</html>
