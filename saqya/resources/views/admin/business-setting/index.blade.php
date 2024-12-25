@extends('admin.layouts.app')

@section('content')
    <div class="row">
        <div class="col-xl-12 mb-4 col-lg-12 col-12">
            <div class="card h-100">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0 text-uppercase">
                            Buinsess Settings
                        </h5>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="card p-3">

        <form id="business-setting-form" action="{{ route('admin.business-setting.update') }}">
            @csrf
            <div class="row g-3">
                <div class="col-md-12">
                    @include('admin.partials.textarea.editor', [
                           'name' => \App\Enums\BusinessSettingEnum::PRIVACY_POLICY_EN->value,
                           'value' => $content->where('key', \App\Enums\BusinessSettingEnum::PRIVACY_POLICY_EN->value)->first()?->value,
                           'label' => \App\Enums\BusinessSettingEnum::PRIVACY_POLICY_EN->label(),
                           'required' => true,
                       ])
                </div>

                <div class="col-md-12">
                    @include('admin.partials.textarea.editor', [
                           'name' => \App\Enums\BusinessSettingEnum::PRIVACY_POLICY_AR->value,
                           'value' => $content->where('key', \App\Enums\BusinessSettingEnum::PRIVACY_POLICY_AR->value)->first()?->value,
                           'label' => \App\Enums\BusinessSettingEnum::PRIVACY_POLICY_AR->label(),
                           'required' => true,
                       ])
                </div>


                <div class="col-md-12">
                    @include('admin.partials.textarea.editor', [
                           'name' => \App\Enums\BusinessSettingEnum::TERMS_CONDITIONS_EN->value,
                           'value' => $content->where('key', \App\Enums\BusinessSettingEnum::TERMS_CONDITIONS_EN->value)->first()?->value,
                           'label' => \App\Enums\BusinessSettingEnum::TERMS_CONDITIONS_EN->label(),
                           'required' => true
                       ])
                </div>
               
         
                <div class="col-md-12">
                    @include('admin.partials.textarea.editor', [
                           'name' => \App\Enums\BusinessSettingEnum::TERMS_CONDITIONS_AR->value,
                           'value' => $content->where('key', \App\Enums\BusinessSettingEnum::TERMS_CONDITIONS_AR->value)->first()?->value,
                           'label' => \App\Enums\BusinessSettingEnum::TERMS_CONDITIONS_AR->label(),
                           'required' => true
                       ])
                </div>
           
            
            </div>
            <div class="row">
                <div class="col-12 d-flex justify-content-center mt-3">
                    <button class="btn btn-primary waves-effect waves-light" type="submit">Submit</button>
                </div>
            </div>
        </form>
    </div>
@endsection
@push('pageCss')
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/quill/typography.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/quill/katex.css') }}"/>
    <link rel="stylesheet" href="{{ asset('admin/vendor/libs/quill/editor.css') }}"/>

@endpush
@push('pageJs')
    <script src="{{ asset('admin/vendor/libs/quill/katex.js') }}"></script>
    <script src="{{ asset('admin/vendor/libs/quill/quill.js') }}"></script>
    <script type="text/javascript">

        // elements
        const FORM = '#business-setting-form'

        $(document).ready(() => {
            // Add/Update record
            $(document).on('submit', FORM, async (event) => {
                event.preventDefault();
                const formData = new FormData(event.target);
                const route = $(event.target).attr('action')
                await sendRequest(route, 'POST', formData, $(event.target)).then((response) => {
                    showToast(response.message)
                });
            })
        })
    </script>
@endpush