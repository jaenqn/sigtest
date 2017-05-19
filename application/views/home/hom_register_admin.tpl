{extends $_template}
{block 'contenido'}
<div class="container">
    <div class="row">
        <div class="col-sm-8">

        <form role="form" class="register-form" id="frmRegistrarAdmin">
            <h2>Crear cuenta administrador<small></small></h2>
            <hr class="colorgraph">
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="form-group">
                        <input type="text" name="first_name" id="first_name" class="form-control input-lg" placeholder="Nombre" tabindex="1">
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="form-group">
                        <input type="text" name="last_name" id="last_name" class="form-control input-lg" placeholder="Apellido" tabindex="2">
                    </div>
                </div>
            </div>

            <div class="form-group">
                <input type="text" name="email" id="email" class="form-control input-lg" placeholder="Cuenta de acceso" tabindex="4">
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="form-group">
                        <input type="password" name="password" id="password" class="form-control input-lg" placeholder="Contraseña" tabindex="5">
                    </div>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-6">
                    <div class="form-group">
                        <input type="password" name="password_confirmation" id="password_confirmation" class="form-control input-lg" placeholder="Confirmar contraseña" tabindex="6">
                    </div>
                </div>
            </div>


            <hr class="colorgraph">
            <div class="row">
                <div class="col-xs-12 col-md-5"><input type="submit" value="Registrar" class="btn btn-theme btn-block btn-lg" tabindex="7"></div>

            </div>
        </form>

        </div>
            <div class="col-sm-4">
                <aside class="right-sidebar">
                <div class="widget">
                    <form role="form">
                      <div class="form-group">
                        <input type="text" class="form-control" id="s" placeholder="Buscar">
                      </div>
                    </form>
                </div>
                <div class="widget">
                    <h5 class="widgetheading">Documentación SIG</h5>
                    <ul class="cat">
                        <li><i class="fa fa-angle-right"></i><a href="#">Documentación SIG|Generales</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="#">Documentación por áreas</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="#">Formatos Seg. Infomación</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="#">Formatos SIG</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="#">Normativa legal</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="#">Otros documentos</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="#">Charlas SIG</a><span></span></li>
                    </ul>
                </div>
                <div class="widget">
                    <h5 class="widgetheading">Enlaces SIG</h5>
                    <ul class="cat">
                        <li><i class="fa fa-angle-right"></i><a href="#">Portal Refinería</a><span></span></li>
                        <li><i class="fa fa-angle-right"></i><a href="#">Correo Web</a><span></span></li>
                    </ul>
                </div>
                {* <div class="widget">
                    <h5 class="widgetheading">Latest posts</h5>
                    <ul class="recent">
                        <li>
                        <img src="img/dummies/blog/65x65/thumb1.jpg" class="pull-left" alt="" />
                        <h6><a href="#">Lorem ipsum dolor sit</a></h6>
                        <p>
                             Mazim alienum appellantur eu cu ullum officiis pro pri
                        </p>
                        </li>
                        <li>
                        <a href="#"><img src="img/dummies/blog/65x65/thumb2.jpg" class="pull-left" alt="" /></a>
                        <h6><a href="#">Maiorum ponderum eum</a></h6>
                        <p>
                             Mazim alienum appellantur eu cu ullum officiis pro pri
                        </p>
                        </li>
                        <li>
                        <a href="#"><img src="img/dummies/blog/65x65/thumb3.jpg" class="pull-left" alt="" /></a>
                        <h6><a href="#">Et mei iusto dolorum</a></h6>
                        <p>
                             Mazim alienum appellantur eu cu ullum officiis pro pri
                        </p>
                        </li>
                    </ul>
                </div> *}
                {* <div class="widget">
                    <h5 class="widgetheading">Popular tags</h5>
                    <ul class="tags">
                        <li><a href="#">Web design</a></li>
                        <li><a href="#">Trends</a></li>
                        <li><a href="#">Technology</a></li>
                        <li><a href="#">Internet</a></li>
                        <li><a href="#">Tutorial</a></li>
                        <li><a href="#">Development</a></li>
                    </ul>
                </div> *}
                </aside>
            </div>
    </div>
</div>

{/block}