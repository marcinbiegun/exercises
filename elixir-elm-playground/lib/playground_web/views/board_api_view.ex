defmodule PlaygroundWeb.BoardApiView do
  use PlaygroundWeb, :view
  alias PlaygroundWeb.BoardApiView

  def render("index.json", %{boards: boards}) do
    %{data: render_many(boards, BoardApiView, "board.json")}
  end

  def render("show.json", %{board: board}) do
    %{data: render_one(board, BoardApiView, "board.json")}
  end

  def render("board.json", %{board_api: board_api}) do
    %{id: board_api.id,
      name: board_api.name,
      user_id: board_api.user_id
    }
  end
end
