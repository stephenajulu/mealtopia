defmodule MealtopiaWeb.Uploads.Images do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original, :thumb]

  def validate({file, _}) do
    ~w(.jpg .jpeg .png) |> Enum.member?(Path.extname(file.file_name))
  end

  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format jpg", :jpg}
  end

  def storage_dir(version, {file, scope}) do
    "uploads/menus/images/#{version}"
  end
end
