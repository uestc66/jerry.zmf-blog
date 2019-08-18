git add .
git commit -m “update”
git push origin master
hexo clean
hexo generate
rm -rf .deploy/uestc66.github.io/archives/*
cp -R public/* .deploy/uestc66.github.io
cd .deploy/uestc66.github.io
git add .
git commit -m “update”
git push origin master