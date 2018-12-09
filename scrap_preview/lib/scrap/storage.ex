 defmodule Scrap.Storage do
   @moduledoc """
   The Storage context.
   """

   import Ecto.Query, warn: false
   alias Scrap.Repo
   alias Scrap.Storage.OfferPoint

   @doc """
   Returns the list of offer points.

   ## Examples

       iex> list_offer_points()
       [%OfferPoint{}, ...]

   """
   def list_offer_points do
     Repo.all(OfferPoint)
   end

   @doc """
   Gets a single offer point.

   Raises `Ecto.NoResultsError` if the OfferPoint does not exist.

   ## Examples

       iex> get_offer_point(123)
       %OfferPoint{}

       iex> get_offer_point(456)
       ** (Ecto.NoResultsError)

   """
   def get_offer_point!(id), do: Repo.get!(OfferPoint, id)

   @doc """
   Creates a offer point.

   ## Examples

       iex> create_offer_point(%{field: value})
       h

       {:ok, %OfferPoint{}}

       iex> create_offer_point(%{field: bad_value})
       {:error, %Ecto.Changeset{}}

   """
   def create_offer_point(attrs \\ %{}) do
     %OfferPoint{}
     |> OfferPoint.changeset(attrs)
     |> Repo.insert()
   end
 end
