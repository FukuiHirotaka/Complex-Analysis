using Plots
using SpecialFunctions

gr()  # backend

# ゼータ関数
f(z) = zeta(z)

# 範囲設定
σ_range = range(0.5, 1.5; length=300)   # 実部
t_range = range(-1, 1; length=300)      # 虚部

# 複素グリッド
S = [complex(σ, t) for t in t_range, σ in σ_range]
F = f.(S)

# 高さ = |ζ(s)|
mag = abs.(F)

# 位相（色用、0〜1正規化）
phase_norm = (angle.(F) .+ π) ./ (2π)

# 発散点（σ=1, t=0 付近）を NaN に
mask = .!(isfinite.(mag) .& isfinite.(phase_norm))
mag[mask] .= NaN
phase_norm[mask] .= NaN

# プロット
plt=surface(
    σ_range, t_range, mag;
    zcolor = phase_norm,
    c = :hsv,
    colorbar = true,
    xlabel = "Re(s)", ylabel = "Im(s)", zlabel = "|ζ(s)|",
    title = "Riemann zeta function ζ(s) "
)
display(plt)
# 保存
savefig(plt, "zeta_surface.png")
savefig(plt, "zeta_surface.pdf")
