#ifndef _LINUX_POWERSUSPEND_H
#define _LINUX_POWERSUSPEND_H

#include <linux/list.h>

#define POWER_SUSPEND_INACTIVE	0
#define POWER_SUSPEND_ACTIVE	1

#define POWER_SUSPEND_AUTOSLEEP	0	// Use kernel autosleep as hook
#define POWER_SUSPEND_USERSPACE	1	// Use fauxclock as trigger
#define POWER_SUSPEND_PANEL	2	// Use display panel state as hook
#define POWER_SUSPEND_HYBRID	3	// Use display panel state and autosleep as hook

struct power_suspend {
				struct list_head link;
						void (*suspend)(struct power_suspend *h);
								void (*resume)(struct power_suspend *h);
};

void register_power_suspend(struct power_suspend *handler);
void unregister_power_suspend(struct power_suspend *handler);

void set_power_suspend_state_autosleep_hook(int new_state);
void set_power_suspend_state_panel_hook(int new_state);

extern bool power_suspended;

#endif
