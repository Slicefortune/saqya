<label class="form-label">
    {{ $label ?? "" }}
    @if(isset($required) && $required)
        <span class="text-danger">*</span>
    @endif
</label>
<input
    type="hidden"
    name="{{ $name ?? "" }}"
    value="{{ $value ?? "" }}"
/>
<div id="{{ "editor-{$name}" }}">
    {!! $value ?? "" !!}
</div>

<script type="text/javascript">
    (function checkQuill() {
        if (typeof Quill === 'undefined') {
            // Quill is not yet defined, so wait and check again after 100 milliseconds
            setTimeout(checkQuill, 100);
        } else {
            // Quill is defined, execute your code
            new Quill("#{{ "editor-{$name}" }}", {
                bounds: "#{{ "editor-{$name}" }}",
                placeholder: 'Type Something...',
                modules: {
                    formula: true,
                    toolbar: [
                        [
                            {
                                font: []
                            },
                            {
                                size: []
                            }
                        ],
                        ['bold', 'italic', 'underline', 'strike'],
                        [
                            {
                                color: []
                            },
                            {
                                background: []
                            }
                        ],
                        [
                            {
                                script: 'super'
                            },
                            {
                                script: 'sub'
                            }
                        ],
                        [
                            {
                                header: '1'
                            },
                            {
                                header: '2'
                            },
                            'blockquote',
                            'code-block'
                        ],
                        [
                            {
                                list: 'ordered'
                            },
                            {
                                list: 'bullet'
                            },
                            {
                                indent: '-1'
                            },
                            {
                                indent: '+1'
                            }
                        ],
                        [{direction: 'rtl'}],
                        ['link', 'image', 'video', 'formula'],
                        ['clean']
                    ]
                },
                theme: 'snow'
            }).on('text-change', function (delta, oldDelta, source) {
                $('input[name="{{$name}}"]').val($("#{{ "editor-{$name}" }}").find('.ql-editor').html());
            });
        }
    })();
</script>
