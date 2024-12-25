@extends('admin.layouts.app')

@section('content')
    <div class="row">
        <div class="col-xl-12 mb-4 col-lg-12 col-12">
            <div class="card h-100">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0 text-uppercase">
                            Users
                        </h5>
                        <small class="text-muted">
                            <button
                                id="create-new"
                                type="button"
                                class="btn btn-primary"
                                data-bs-toggle="modal"
                                data-bs-target="#modal">
                                Create New
                            </button>
                        </small>
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
@push('pageCss')

@endpush
@push('pageJs')
    {{ $dataTable->scripts() }}

    <script type="text/javascript">
        // routes
        const CREATE_ROUTE = '{{ route('admin.user.create') }}'
        const EDIT_ROUTE = '{{ route('admin.user.edit', '_ID_') }}'
        const DELETE_ROUTE = '{{ route('admin.user.destroy', '_ID_') }}'

        // elements
        const CREATE_BUTTON = '#create-new'
        const EDIT_BUTTON = '.edit-item'
        const DELETE_BUTTON = '.delete-item'
        const MODAL = '#modal'
        const MODAL_INNER = '#modalInner'
        const MODAL_INNER_LOADER = '#modalInnerLoader'
        const MODAL_FORM = "#modalForm"
        const DATATABLE = '#users-table'
        const CSRF_TOKEN = '{{ csrf_token() }}'

        $(document).ready(() => {
            // Load create form
            $(document).on('click', CREATE_BUTTON, async () => {
                $(MODAL_INNER_LOADER).removeClass('d-none')
                $(MODAL_INNER).html('')
                await sendRequest(CREATE_ROUTE, 'GET').then((response) => {
                    $(MODAL_INNER_LOADER).addClass('d-none')
                    $(MODAL_INNER).html(response.data.html)
                    $(DATATABLE).DataTable().ajax.reload();
                });
            })

            // Load Edit form
            $(document).on('click', EDIT_BUTTON, async (event) => {
                $(MODAL_INNER_LOADER).removeClass('d-none')
                $(MODAL_INNER).html('')
                $(MODAL).modal('show')
                const id = $(event.target).closest('tr').attr('id')
                sendRequest(EDIT_ROUTE.replace('_ID_', id), 'GET').then((response) => {
                    $(MODAL_INNER_LOADER).addClass('d-none')
                    $(MODAL_INNER).html(response.data.html)
                    $(DATATABLE).DataTable().ajax.reload();
                })
            })

            // Add/Update record
            $(document).on('submit', MODAL_FORM, async (event) => {
                event.preventDefault();
                const formData = new FormData(event.target);
                const route = $(event.target).attr('action')
                await sendRequest(route, 'POST', formData, $(event.target)).then((response) => {
                    $(MODAL).modal('hide')
                    $(MODAL_INNER).html('')
                    showToast(response.message)
                    $(DATATABLE).DataTable().ajax.reload();
                });
            })

            // Delete Record
            $(document).on('click', DELETE_BUTTON, async (event) => {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "You won't be able to recover this record!",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Yes, delete it!',
                    customClass: {
                        confirmButton: 'btn btn-primary me-3 waves-effect waves-light',
                        cancelButton: 'btn btn-label-secondary waves-effect waves-light'
                    },
                    buttonsStyling: false
                }).then(async function (result) {
                    if (result.value) {
                        const id = $(event.target).closest('tr').attr('id')
                        let formData = new FormData();
                        formData.append('_token', CSRF_TOKEN)
                        formData.append('_method', 'DELETE')
                        sendRequest(DELETE_ROUTE.replace('_ID_', id), 'POST', formData).then(() => {
                            Swal.fire({
                                icon: 'success',
                                title: 'Deleted!',
                                text: 'Record has been deleted.',
                                customClass: {
                                    confirmButton: 'btn btn-success waves-effect waves-light'
                                }
                            });
                            $(DATATABLE).DataTable().ajax.reload();
                        })
                    }
                });
            })
        })
    </script>
@endpush
