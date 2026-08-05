from pathlib import Path

logs = ['build_release.log', 'pub_get.log']
for log in logs:
    p = Path(log)
    print(f'=== {log} ===')
    if not p.exists():
        print('MISSING')
        continue
    print('size=', p.stat().st_size)
    for enc in ['utf-16', 'utf-8', 'utf-16-le', 'utf-16-be']:
        try:
            text = p.read_text(encoding=enc, errors='replace')
            lines = text.splitlines()
            print('encoding=', enc, 'lines=', len(lines))
            for i, line in enumerate(lines[:40], 1):
                print(f'{i:03}: {line}')
            print('--- last 40 lines ---')
            for i, line in enumerate(lines[-40:], 1):
                print(f'{len(lines)-40+i:03}: {line}')
            break
        except Exception as e:
            print('failed encoding', enc, e)
    print()
