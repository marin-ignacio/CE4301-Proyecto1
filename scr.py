from cStringIO import StringIO
from intelhex import IntelHex
ih = IntelHex()
ih[0] = 0x55
sio = StringIO()
ih.write_hex_file(sio)
hexstr = sio.getvalue()
sio.close()
