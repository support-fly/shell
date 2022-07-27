#!/bin/bash

# 找到关键字所在行，并将该行内容替换
sed -i "s/keywords*/replace_words/g" `grep -rl "keywords"`
