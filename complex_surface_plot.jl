using Plots
gr()  # backend

# 複素関数 f(z) = 1 / (1 - z)
f(z) = 1 / (1 - z)

# 範囲設定
σ_range = range(0.5, 1.5; length=300)   # 実部
t_range = range(-1, 1; length=300)      # 虚部

# 複素グリッド
S = [complex(σ, t) for t in t_range, σ in σ_range]
F = f.(S)

# 高さ = |f(z)|
mag = abs.(F)

# 位相（色用、0〜1正規化）
phase_norm = (angle.(F) .+ π) ./ (2π)

# 発散点を NaN に（1 - z = 0 の点）
mask = .!(isfinite.(mag) .& isfinite.(phase_norm))
mag[mask] .= NaN
phase_norm[mask] .= NaN

# プロット
plt = surface(
    σ_range, t_range, mag;
    zcolor = phase_norm,
    c = :hsv,
    colorbar = true,
    xlabel = "Re(z)", ylabel = "Im(z)", zlabel = "|1/(1-z)|",
    title = "Complex function 1/(1-z)"
)

# 表示
display(plt)

# 保存
savefig(plt, "complex_surface.png")
savefig(plt, "complex_surface.pdf")
