import hashlib

sha1 = lambda value: hashlib.sha1(value.strip().encode()).hexdigest()

bool = lambda value: value.lower() == "true"