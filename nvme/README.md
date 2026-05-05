# nvme

`nvme-power.cfg` — drop-in for `/etc/default/grub.d/`. Appends
`nvme_core.default_ps_max_latency_us=0` to `GRUB_CMDLINE_LINUX_DEFAULT`,
which disables NVMe APST (Autonomous Power State Transitions). The drive
stays fully awake instead of entering deep sleep states with multi-hundred-ms
wake latencies.

Why: this Zenbook's WD SSD has APST states that occasionally don't wake
fast enough, producing `nvme: I/O timeout` and stalling boot (incident
2026-03-21). Cost is ~3-5 W extra at idle.

How it activates: `grub-mkconfig` (run by `update-grub`, which the kernel
postinst hook `/etc/kernel/postinst.d/zz-update-grub` invokes on every
kernel install) sources every `*.cfg` in `/etc/default/grub.d/` and bakes
the resulting cmdline into `/boot/grub/grub.cfg`.

Install on a new machine:

    sudo ln -s ~/backlin/dotfiles/nvme/nvme-power.cfg /etc/default/grub.d/nvme-power.cfg
    sudo update-grub
    # reboot
