function download_raster(::Type{CHELSA}, ::Type{BioClim}; layer::Integer=1)
    1 ≤ layer ≤ 19 || throw(ArgumentError("The layer must be between 1 and 19"))
    path = SimpleSDMDataSources._raster_assets_folder(CHELSA, BioClim)
    layer = lpad(layer, 2, "0")
    filename = "CHELSA_bio10_$(layer).tif"
    url_root = "ftp://envidatrepo.wsl.ch/uploads/chelsa/chelsa_V1/climatologies/bio/"

    filepath = joinpath(path, filename)
    if !(isfile(filepath))
        res = HTTP.request("GET", url_root * filename)
        open(filepath, "w") do f
            write(f, String(res.body))
        end
    end
    return filepath
end