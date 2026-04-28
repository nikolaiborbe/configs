import numpy as np; import matplotlib.pyplot as plt

plt.rcParams.update({
    "font.family": "serif",
    "mathtext.fontset": "stix",
    "xtick.direction": "in",
    "ytick.direction": "in",
    "xtick.top": True,
    "ytick.right": True,
    "legend.fancybox": False,

    # slightly larger text
    "font.size": 12,
    "axes.labelsize": 13,
    "xtick.labelsize": 12,
    "ytick.labelsize": 12,
    "legend.fontsize": 12,
})

f = lambda x: x**2 
x = np.arange(1, 10)
y = f(x)

plt.plot(x,y, label="32 kHz", color="black")
plt.xlabel("Pump power [mW]")
plt.ylabel("Noise [mHz]")
plt.legend()

plt.savefig("figure.pdf", bbox_inches="tight")

plt.show()

