<label class="form-label">
    {{ $label ?? "" }}
    @if(isset($required) && $required)
        <span class="text-danger">*</span>
    @endif
</label>
<input
    type="{{ $type ?? "text" }}"
    name="{{ $name ?? "" }}"
    class="form-control {{ $classes ?? "" }}"
    placeholder="{{ $label ?? "" }}"
    value="{{ $value ?? "" }}"
    {{ (isset($required) && $required) ? "required" : '' }}
/>
@if(isset($type) && $type == 'file' && isset($value) && $value != '')
    <!-- Display image -->
    <div class="py-2 d-flex justify-content-center">
        <img src="{{ asset(\Illuminate\Support\Facades\Storage::url($value)) }}" alt="Image" height="75px"/>
    </div>
@endif
