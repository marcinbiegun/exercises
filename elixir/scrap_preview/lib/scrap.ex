defmodule Scrap do

  @moduledoc """
  Basic domain data is kept in this module:
  - list of valid brands
  - list of valid stores
  - list of valid currencies
  """

  @brands [ :adidas, :nike, :new_balance ]
  @stores [ :dummy, :sneakerstudiopl ]
  @currencies [ :pln ]

  @spec brands() :: [atom]
  def brands() do
    @brands
  end

  @spec brands(:string) :: [String.t]
  def brands(:string) do
    @brands |> Enum.map(fn name -> "#{name}" end)
  end

  @spec stores() :: [atom]
  def stores() do
    @stores
  end

  @spec stores(:string) :: [String.t]
  def stores(:string) do
    @stores |> Enum.map(fn name -> "#{name}" end)
  end

  @spec currencies() :: [atom]
  def currencies() do
    @currencies
  end

  @spec currencies(:string) :: [atom]
  def currencies(:string) do
    @currencies |> Enum.map(fn name -> "#{name}" end)
  end
end
