# SSH Configuration

Once the contents of this folder change, update this document.

## Architecture
SSH client configuration for remote server access. Managed with GNU Stow for symlinking to `~/.ssh/`. Private keys are NOT versioned for security.

## Files
- **config**: SSH client configuration (host aliases, proxy jumps, port forwarding)
- **.gitignore**: Prevents committing sensitive key files
- **README.md**: This documentation

## Security
⚠️ **Private keys and sensitive files are excluded from git via `.gitignore`**

Only the SSH client config file (which contains host aliases and connection settings) is version controlled. This file does NOT contain passwords or private keys.

## Setup
Use GNU Stow to symlink this configuration:
```bash
cd ~/dotfiles
stow ssh
```

This will create: `~/.ssh/config -> ~/dotfiles/ssh/.ssh/config`

## Related Documentation
See `../docs/ssh-remote-access-setup.md` for complete SSH server setup guide including:
- Remote access via Tailscale
- SSH key generation
- iPhone/Terminus configuration
- Security best practices
