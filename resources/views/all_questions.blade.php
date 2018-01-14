

@foreach($questions as $question)
    <p>{{ $question->id }} - {{ $question->question }}</p>
    @foreach($question_images[$question->id] as $image)
        <img src="{{ Storage::url($image) }}">
    @endforeach
    <ul>
        @foreach($question->keywords as $keyword)
            <li>{{ $keyword->keyword }}</li>
        @endforeach
    </ul>
@endforeach



{{ $questions->links() }}