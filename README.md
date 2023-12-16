# McFirewalls
Simple management of Windows Firewall rules for a Minecraft server.

McFirewalls is a Windows batch script designed to simplify the management of firewall rules for Minecraft servers. This script is written entirely by ChatGPT, I hope you find it useful. The script streamlines the process of adding or removing firewall rules associated with Minecraft Servers.

## What it can do

1. **Adding Firewall Rules:**
   - Y'all can now easily add firewall rules for your Minecraft servers to allow incoming and outgoing traffic on the specified port (default is '25565').
   - Custom RuleName and Port values can be entered for personalized configurations
   i.e. if you want to run two servers on diffrent ports for god knows what reason
   - The script checks if the firewall rules already exist before attempting to add them.
   This was a nightmare to fix honestly at somepoint I had about 20 of the same rule, its fixed tho, dont worry

2. **Removing Firewall Rules:**
   - Users can remove previously added firewall rules associated with a Minecraft server.
   So yeah basicly the opposite of the above
   - The script prompts for the RuleName and automatically removes the corresponding rules (TCP Inbound, UDP Inbound, TCP Outbound, UDP Outbound). 
   - If no rules are found for the specified RuleName, a corresponding message is displayed.

## Prerequisites

- The script requires administrator privileges to modify firewall rules.
- Have a Windows System

## How to Use

1. Run the script with administrator privileges.
   - Right-click on the command prompt icon and select "Run as administrator."

2. Choose the desired action: 'add' or 'remove.'

3. Provide additional information based on the chosen action:
   - For 'add': Specify whether to use custom RuleName and Port values.
   - For 'remove': Confirm if the server had a custom RuleName.

4. Follow on-screen prompts to enter custom values or use default configurations.

5. The script will either add or remove firewall rules accordingly, providing feedback on the operation's success or failure.

## Example Usage

```bash
> McFirewalls.bat
```
Wow so simple!

## Disclaimer

This script is provided as-is, and the authors assume no responsibility for any issues or damages resulting from its use. Users are encouraged to review and understand the script's functionality before execution.

Not sure why ChatGPT added this but i'm gonna keep it in here just incase.

## Credits

- **Author:** ChatGPT
- **Requested by:** Xaevien

AYYYY CHATGPT WHY YOU PLACE YOUR NAME ON TOP OF MINE, OML ITS THE AI UPRISING D;

Feel free to contribute to the script or report issues through GitHub. Happy Minecrafting!

Thanks for that ChatGPT, Yeah do what it said, I will prolly never touch this again.
