defmodule PlaygroundWeb.PageControllerTest do
  use PlaygroundWeb.ConnCase
  alias Playground.Coherence.User, as: User
  alias Playground.Repo, as: Repo

  describe "Unsigned user" do
    test "GET /", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "elm-container"
      assert html_response(conn, 200) =~ "Sign in"
    end
  end

  describe "Signed user" do
    setup %{conn: conn} do
      user = User.changeset(%User{}, %{name: "test", email: "test@example.com", password: "test", password_confirmation: "test"})
      |> Repo.insert!
      {:ok, conn: assign(conn, :current_user, user), user: user}
    end

    test "GET /", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "elm-container"
      assert html_response(conn, 200) =~ "Signed in"
    end
  end


end
