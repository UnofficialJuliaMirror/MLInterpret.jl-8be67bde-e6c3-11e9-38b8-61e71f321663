using PyCall: python
using Pkg.GitTools: clone

isnothing(Sys.which("dot")) && run(`sudo apt-get install -y graphviz`)

run(`$python -m pip install pandas sklearn matplotlib lightgbm shap keras tzlocal PyPDF2 unidecode`)

occursin("skater", read(`$python -m pip list`, String)) && exit(0)

if get(ENV, "MLI_RL", "0") == "1"
    skater = mktempdir()
    clone("https://github.com/oracle/Skater.git", skater)
    run(`sed -i "s|sudo python|$python|g" $skater/setup.sh`)
    run(`sed -i "s|.*install python.*||g" $skater/setup.sh`)
    run(`sed -i "s|apt-get install|apt-get install -y|g" $skater/setup.sh`)
    run(`bash -c "cd $skater && $python setup.py install --ostype=linux-ubuntu --rl=True"`)
else
    run(`$python -m pip install skater`)
end