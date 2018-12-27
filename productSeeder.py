#!/usr/bin/env python3

print('Product.destroy_all\n\nProduct.create!([')
with open('ProductList.csv', 'r') as infile:
    first = True
    output = ''
    for line in infile:
        if first:
            if line[0] == '\ufeff':  # Mac Excel weirdness
                line = line[1:]
        else:
            print('},')
        first = False

        fields = line.split(',')
        name = fields[0].strip('$')
        price = float(fields[1].strip('$'))
        cogs = price * 0.65 * 0.45  # 45% discount leaves 55% gross margin
        lb = '{'
        print(f'{lb}\n  name:"{name}",')
        print(f'  price:{price:.2f},')
        print(f'  cogs:{cogs:.2f}')
    print('}])')



