defmodule PlaygroundWeb.TaskApiView do
  use PlaygroundWeb, :view
  alias PlaygroundWeb.TaskApiView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskApiView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskApiView, "task.json")}
  end

  def render("task.json", %{task_api: task_api}) do
    %{id: task_api.id,
      name: task_api.name,
      description: task_api.description,
      weight: task_api.weight,
      is_done: task_api.is_done,
      column_id: task_api.column_id}
  end
end
