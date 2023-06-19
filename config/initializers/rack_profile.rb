# rack-mini-profiler（左上の時間・秒(ms)の表示）


if Rails.env == 'development'

# true 非表示
Rack::MiniProfiler.config.start_hidden = true

end