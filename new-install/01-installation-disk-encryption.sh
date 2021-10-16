set -e
set -x

BLOCK_DEVICE=/dev/nvme1n1
EFI_PARTITION="${BLOCK_DEVICE}p1"
BOOT_PARTITION="${BLOCK_DEVICE}p2"
ENCRYPTED_PARTITION="${BLOCK_DEVICE}p3"

# Setup LUKS
cryptsetup luksFormat "${ENCRYPTED_PARTITION}"
cryptsetup open "${ENCRYPTED_PARTITION}" cryptlvm

# Create a physical volume on top of the opened LUKS container:
pvcreate /dev/mapper/cryptlvm

# Create a volume group (in this example named MyVolGroup, but it can be whatever you want) and add the previously created physical volume to it:
vgcreate MyVolGroup /dev/mapper/cryptlvm

# Create all your logical volumes on the volume group:
lvcreate -L 8G MyVolGroup -n swap
lvcreate -L 100G MyVolGroup -n root
lvcreate -l 100%FREE MyVolGroup -n home

# Format your filesystems on each logical volume:
mkfs.ext4 /dev/MyVolGroup/root
mkfs.ext4 /dev/MyVolGroup/home
mkswap /dev/MyVolGroup/swap

# Mount your filesystems:
mount /dev/MyVolGroup/root /mnt
mkdir /mnt/home
mount /dev/MyVolGroup/home /mnt/home
swapon /dev/MyVolGroup/swap

# Preparing the boot partition
mkfs.fat -F32 "${BOOT_PARTITION}"
mkfs.fat -F32 "${EFI_PARTITION}"
mkdir /mnt/boot
mount "${BOOT_PARTITION}" /mnt/boot
mkdir /mnt/boot/efi
mount "${EFI_PARTITION}" /mnt/boot/efi

