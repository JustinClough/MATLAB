function Area=homeplate(Dimension);
Area(1)=Dimension(1)*Dimension(2);
Area(2)=Dimension(1)*(Dimension(3)-Dimension(2))*.5;
Area(3)=Area(1)+Area(2);