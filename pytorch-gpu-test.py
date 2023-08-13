import torch

is_available = torch.cuda.is_available()
print('CUDA available:', is_available)
if is_available:
    device_count = torch.cuda.device_count()
    print('Device count:', device_count)
    print('Devices:')
    for i in range(device_count):
        print('  -', torch.cuda.get_device_name(i))
