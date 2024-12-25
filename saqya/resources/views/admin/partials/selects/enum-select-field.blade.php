<label class="form-label">
    {{ $label ?? "" }}
    @if(isset($required) && $required)
        <span class="text-danger">*</span>
    @endif
</label>
<select
    name="{{ $name ?? "" }}"
    class="{{ $name }}-selectpicker w-100 {{ $classes ?? "" }}"
    {{ (isset($required) && $required) ? "required" : '' }}
    data-style="btn-default">
    @foreach($options as $option)
        <option value="{{ $option->value }}"
                @if(isset($value) &&$option->value == $value->value) selected @endif>
            {{ $option->label() }}
        </option>
    @endforeach
</select>
<script>
    $('.{{ $name }}-selectpicker').selectpicker();
</script>
