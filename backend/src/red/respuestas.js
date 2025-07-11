exports.success = (req, res, mensaje = '', status = 200) => {
  res.status(status).send({
    error: false,
    status,
    body: mensaje
  });
};

exports.error = (req, res, mensaje = 'Error Interno', status = 500) => {
  res.status(status).send({
    error: true,
    status,
    body: mensaje
  });
};
