
<div class="text-center mb-4">
    <h3 class="address-title mb-2">{{ $title ?? "Form Title" }}</h3>
</div>
<form id="modalForm" class="row g-3" action="{{ $actionRoute }}" method="POST">
    @csrf
    @method($actionMethod)

    <div class="col-md-6">
        @include('admin.partials.inputs.input-field', [
            'name' => 'name',
            'value' => isset($item) ? $item->name : '',
            'label' => 'Name',
            'required' => true
        ])
    </div>

    <div class="col-md-6">
        @include('admin.partials.inputs.input-field', [
            'name' => 'name_ar',
            'value' => isset($item) ? $item->name_ar : '',
            'label' => 'Name (Arabic)',
            'required' => true
        ])
    </div>

    <div class="col-md-6">
        @include('admin.partials.inputs.input-field', [
            'name' => 'price',
            'value' => isset($item) ? $item->price : '',
            'label' => 'Price',
            'required' => true
        ])
    </div>

    <div class="col-md-6">
        @include('admin.partials.inputs.input-field', [
            'name' => 'size',
            'value' => isset($item) ? $item->size : '',
            'label' => 'Size',
            'required' => true
        ])
    </div>
    <div class="col-md-6">
        @include('admin.partials.selects.enum-select-field', [
            'name' => 'status',
            'label' => 'Status',
            'required' => true,
            'value' => isset($item) ? $item->status : null,
            'options' => \App\Enums\StatusEnum::cases()
        ])
    </div>
   

    <div class="col-md-6">
        @include('admin.partials.inputs.input-field', [
            'name' => 'image',
            'label' => 'Products Image ( 524 x 487 )',
            'type' => 'file',
            'required' => !isset($item),
            'value' => isset($item) ? $item->image : null,
        ])
    </div>
   
    <hr class="col-12"/>
    <div class="col-12 text-center">
        <button type="submit" class="btn btn-primary me-sm-3 me-1">Submit</button>
        <button
            type="reset"
            class="btn btn-label-secondary"
            data-bs-dismiss="modal"
            aria-label="Close">
            Cancel
        </button>
    </div>
</form>