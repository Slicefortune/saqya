<label class="form-label">
    {{ $label ?? "" }}
    @if(isset($required) && $required)
        <span class="text-danger">*</span>
    @endif
</label>
<select
    name="{{ $name}}"
    class="{{ $name }}-select2 form-select {{ $classes ?? "" }}"
    {{ (isset($required) && $required) ? "required" : '' }}
    data-allow-clear="true">
    <option value="">Select {{ $label ?? "" }}</option>
    @foreach($options as $optionValue => $optionLabel)
        <option value="{{ $optionValue }}" @if($optionValue == $value) selected @endif>{{ $optionLabel }}</option>
    @endforeach
</select>
<script>
    $('.{{ $name }}-select2').wrap('<div class="position-relative"></div>').select2({
        placeholder: 'Select  {{ $label ?? "" }}',
        dropdownParent: $('.{{ $name }}-select2').parent()
    });
</script>
