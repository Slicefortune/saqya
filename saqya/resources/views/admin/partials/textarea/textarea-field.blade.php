<label class="form-label">
    {{ $label ?? "" }}
    @if(isset($required) && $required)
        <span class="text-danger">*</span>
    @endif
</label>
<textarea
    class="form-control {{ $classes ?? "" }}"
    name="{{ $name ?? "" }}"
    id="{{ $id ?? "" }}"
    {{ (isset($required) && $required) ? "required" : '' }}
    rows="{{ $row ?? 3 }}">{{ $value ?? "" }}</textarea>
