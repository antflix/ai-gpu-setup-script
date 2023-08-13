import tensorflow as tf

device_list = tf.config.list_physical_devices('GPU')
print('Available GPUs:', len(device_list))
if device_list:
    print('Devices:')
    for device in device_list:
        print('  -', tf.config.experimental.get_device_details(device))
