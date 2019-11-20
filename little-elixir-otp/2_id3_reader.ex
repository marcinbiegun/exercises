defmodule ID3Parser do
  def parse(filepath) do
    case File.read(filepath) do
      {:ok, content} ->
        read_id3(content)
      _ ->
        IO.puts "Unable to open file #{filepath}"
    end
  end

  defp read_id3(content) do
    music_byte_size = byte_size(content) - 128
    << _music_content :: binary-size(music_byte_size), id3_content :: binary >> = content

    <<
      "TAG",
       title :: binary-size(30),
       artist :: binary-size(30),
       album :: binary-size(30),
       year :: binary-size(4),
       _rest :: binary
    >> = id3_content

    %{
      title: title |> to_utf8,
      artist: artist |> to_utf8,
      album: album |> to_utf8,
      year: year |> to_utf8
    }
  end
end

ID3Parser.parse("assets/sample.mp3")
|> Enum.map(fn {key, value} ->
  IO.puts("#{key}: #{value}")
end)
